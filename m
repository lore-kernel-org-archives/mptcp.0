Content-Type: multipart/mixed; boundary="===============5522151960807173984=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 17 Oct 2019 15:38:51 +0200
Message-ID: <15d265f1-6130-4510-44dc-e710ef71a813@tessares.net>
In-Reply-To: d8bd92945661a2d41195dc3249249a3eae445935.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2213

--===============5522151960807173984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

+cc Florian

Thank you for the reviews!

On 17/10/2019 15:26, Paolo Abeni wrote:
> Hi,
> =

> On Thu, 2019-10-10 at 16:27 +0200, Matthieu Baerts wrote:
>> WARNING: line over 80 characters
>> #233: FILE: net/mptcp/options.c:47:
>> +                * negotiated, the receiver MUST close the subflow with =
a RST as it is
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "mptcp: Handle MPTCP TCP options"
>>
>>   net/mptcp/options.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index cee4280647fe..adf65d3ff27b 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -44,8 +44,8 @@ void mptcp_parse_option(const unsigned char *ptr, int =
opsize,
>>   		 *
>>   		 * Section 3.3.0:
>>   		 * "If a checksum is not present when its use has been
>> -		 * negotiated, the receiver MUST close the subflow with a RST as it is
>> -		 * considered broken."
>> +		 * negotiated, the receiver MUST close the subflow with a RST as
>> +		 * it is considered broken."
>>   		 *
>>   		 * We don't implement DSS checksum - fall back to TCP.
>>   		 */
> =

> This one and the next 2 patches are IMHO uncontroversially good, but
> the 4th is a bit against my personal taste - I would keep the
> checkpatch offenders instead;). No objections on the 5th patch.

I am fine to drop the 4th one. Florian mentioned earlier that it is =

better to fix checkpatch issues than having comments about that during =

the reviews or dedicated patches later to fix just that. But because =

Florian wrote this code (mptcp_snmp_list + linux_mptcp_mib_field), I =

guess he is also fine not to follow checkpatch rules :)

I am going to apply the other patches, they are not linked to each others.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5522151960807173984==--
