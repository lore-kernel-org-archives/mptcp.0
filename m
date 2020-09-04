Content-Type: multipart/mixed; boundary="===============8901572147847930112=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] tcp: propagate MPTCP skb extensions on xmit
 splits
Date: Fri, 04 Sep 2020 18:44:08 +0200
Message-ID: <c1f4b701-102f-8e56-df69-df10b72dd0de@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2009030803370.30999@candidom-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5726

--===============8901572147847930112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 03/09/2020 17:04, Mat Martineau wrote:
> On Wed, 2 Sep 2020, Paolo Abeni wrote:
> =

>> When the TCP stack splits a packet on the write queue, the tail
>> half currently lose the associated skb extensions, and will not
>> carry the DSM on the wire.
>>
>> The above does not cause functional problems and is allowed by
>> the RFC, but interact badly with GRO and RX coalescing, as possible
>> candidates for aggregation will carry different TCP options.
>>
>> This change tries to improve the MPTCP behavior, propagating the
>> skb estensions on split.
>>
>> Additionally, we must prevent the MPTCP stack from updating the
>> mapping after the split occour: that will both violate the RFC and
>> fool the reader.
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>> v1 -> v2:
>> - move 'frozen' initialization above the copy - Mat
> =

> Looks good to me, thank you!

Thank you for the patch and the review!

(I just fixed two typos in the commit messages with "occour" and =

"estensions" reported by codespell via checkpatch :) )

Just added the patch at the end of the series!

Tests + export are in progress.

Cheers,
Matt

-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8901572147847930112==--
