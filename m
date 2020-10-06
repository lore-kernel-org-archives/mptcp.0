Content-Type: multipart/mixed; boundary="===============4113698667627546562=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Tue, 06 Oct 2020 14:28:35 +0200
Message-ID: <aa9df75e-d5ca-9436-6211-295ddf12032b@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2010051721010.13171@srinathb-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6216

--===============4113698667627546562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 06/10/2020 02:21, Mat Martineau wrote:
> On Mon, 5 Oct 2020, Paolo Abeni wrote:
> =

>> With the additional SM handling, fallback socket will
>> go through an unneeded timeout, because they never
>> get the DATA_FIN from the peer.
>>
>> In case of fallback, we can just close the msk and
>> invoke directly tcp_close on the subflow.
>>
>> This fixes diag.sh self-tests failure in current export
>> branch
> =

> Looks good to me. Thanks Paolo.

Thank you for the patch and the review!

- a98dba029718: "squashed" in "mptcp: refactor shutdown and close"
- Results: 10c53117392d..b74dfa0c4018

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4113698667627546562==--
