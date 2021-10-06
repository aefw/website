<?php
/*
 * Copyright 2014 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

namespace Google\Service\FactCheckTools;

class GoogleFactcheckingFactchecktoolsV1alpha1FactCheckedClaimSearchResponse extends \Google\Collection
{
  protected $collection_key = 'claims';
  protected $claimsType = GoogleFactcheckingFactchecktoolsV1alpha1Claim::class;
  protected $claimsDataType = 'array';
  public $nextPageToken;

  /**
   * @param GoogleFactcheckingFactchecktoolsV1alpha1Claim[]
   */
  public function setClaims($claims)
  {
    $this->claims = $claims;
  }
  /**
   * @return GoogleFactcheckingFactchecktoolsV1alpha1Claim[]
   */
  public function getClaims()
  {
    return $this->claims;
  }
  public function setNextPageToken($nextPageToken)
  {
    $this->nextPageToken = $nextPageToken;
  }
  public function getNextPageToken()
  {
    return $this->nextPageToken;
  }
}

// Adding a class alias for backwards compatibility with the previous class name.
class_alias(GoogleFactcheckingFactchecktoolsV1alpha1FactCheckedClaimSearchResponse::class, 'Google_Service_FactCheckTools_GoogleFactcheckingFactchecktoolsV1alpha1FactCheckedClaimSearchResponse');
