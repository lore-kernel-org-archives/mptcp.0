Content-Type: multipart/mixed; boundary="===============6831229266496785003=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: refactor shutdown and close"
Date: Sat, 17 Oct 2020 09:56:46 +0200
Message-ID: <86c80a2d-3e88-fea1-465a-9ef29d33ee49@tessares.net>
In-Reply-To: b926d53fa15a1e9c11de69a10a721b4ec85e926a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6339

--===============6831229266496785003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Davide,

On 15/10/2020 16:00, Davide Caratti wrote:
> On Thu, 2020-10-15 at 15:26 +0200, Paolo Abeni wrote:
>> Currently we can miss the msk timeout event in several
>> circumstances (e.g. no outstanding data).
>>
>> Let's use a separate timer to keep track of the timeout
>> after close().
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---
>>   net/mptcp/protocol.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> =

> LGTM.

Thank you for the patch and the review!

- fa6aac14613c: "squashed" in "mptcp: refactor shutdown and close"
- 3141c7617e40: conflict in t/DO-NOT-MERGE-mptcp-use-kmalloc-on-kasan-build
- Results: 0e70ef7be280..e41dc6548e3b

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6831229266496785003==--
