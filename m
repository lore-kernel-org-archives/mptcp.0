Content-Type: multipart/mixed; boundary="===============0235820626504102506=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 1/1] mptcp: fix stale
 subflow->writeable caching
Date: Fri, 28 Aug 2020 21:15:14 +0200
Message-ID: <e6f11fba-d787-c8b2-f3f1-1e340b5db5af@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2008211209290.9615@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 5662

--===============0235820626504102506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 21/08/2020 21:10, Mat Martineau wrote:
> On Fri, 21 Aug 2020, Florian Westphal wrote:
> =

>> Even with fixed subflow_write_space(), we may still indicate EPOLLOUT
>> even if no subflow is writeable.
>>
>> We need to re-check the last ssk that was used after the final =

>> tcp_push().
>> tcp_push() can allocate new skbs that get charged to the subflow sk
>> which may bring it above the wmem limit.
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> =

> Thanks Florian. All three patches look good to me.

Thank you for the patch and the review!

Applied at the end of the series.

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0235820626504102506==--
