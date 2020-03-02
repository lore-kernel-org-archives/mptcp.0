Content-Type: multipart/mixed; boundary="===============6085636027853196692=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/2] mptcp: fix compilation warning without IPv6
Date: Mon, 02 Mar 2020 17:18:09 +0100
Message-ID: <b1756e62-85dc-6118-b108-b3225a51dc13@tessares.net>
In-Reply-To: 255884997d97f8bdae42df1eb2c012f5b97d7919.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3846

--===============6085636027853196692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 02/03/2020 17:05, Paolo Abeni wrote:
> On Mon, 2020-03-02 at 16:56 +0100, Matthieu Baerts wrote:
>> net/mptcp/pm_netlink.c: In function =E2=80=98mptcp_pm_nl_append_new_loca=
l_addr=E2=80=99:
>> net/mptcp/pm_netlink.c:58:5: warning: =E2=80=98addr_equals=E2=80=99 may =
be used uninitialized in this function [-Wmaybe-uninitialized]
>>     58 |  if (!addr_equals)
>>        |     ^
>> net/mptcp/pm_netlink.c:46:7: note: =E2=80=98addr_equals=E2=80=99 was dec=
lared here
>>     46 |  bool addr_equals;
>>        |       ^~~~~~~~~~~
>>
>> Fixes: c3a214585944 (mptcp: add netlink based PM)
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "mptcp: add netlink based PM"
>>
>>   net/mptcp/pm_netlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 0887fae982fc..4cbf338c0d2c 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -43,7 +43,7 @@ struct pm_nl_pernet {
>>   static bool addresses_equal(const struct mptcp_addr_info *a,
>>   			    struct mptcp_addr_info *b, bool use_port)
>>   {
>> -	bool addr_equals;
>> +	bool addr_equals =3D false;
>>   =

>>   	if (a->family !=3D b->family)
>>   		return false;
> =

> The series (patch 1 and 2) LGTM, thanks!

Thank you for the review!

- c04914d046f0: "squashed" in "mptcp: Add handling of outgoing MP_JOIN =

requests"
- 9987941c10c3: "squashed" in "mptcp: add netlink based PM"
- b48bbfeadf3b..512b7f2ab36f: result

Tests + export in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6085636027853196692==--
