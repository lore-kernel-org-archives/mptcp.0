Content-Type: multipart/mixed; boundary="===============4860016282912692855=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] Squash-to: "mptcp: add netlink-based
 PM"
Date: Thu, 26 Mar 2020 11:34:33 +0100
Message-ID: <03ea8345-c10a-7434-9a3e-37a7fd693fba@tessares.net>
In-Reply-To: 4a951891dbdb4812406e7dbf9af9f61d65b7353c.1585217878.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4071

--===============4860016282912692855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 26/03/2020 11:19, Paolo Abeni wrote:
> Let user space set a single limit at once and drop bogus
> NL extack error message.

Thank you for the patch!

> =

> v1 -> v2:
>   - do not include dumb dbg messages
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   net/mptcp/pm_netlink.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 743c3c58f826..caad73dfda64 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -702,10 +702,8 @@ static int parse_limit(struct genl_info *info, int i=
d, unsigned int *limit)
>   {
>   	struct nlattr *attr =3D info->attrs[id];
>   =

> -	if (!attr) {
> -		GENL_SET_ERR_MSG(info, "missing announce accept limit");
> -		return -EINVAL;
> -	}
> +	if (!attr)
> +		return 0;

I guess we don't need to return an error if no attributes are given for =

both RCV_ADD_ADDRS and SUBFLOWS, right?

>   =

>   	*limit =3D nla_get_u32(attr);
>   	if (*limit > MPTCP_PM_ADDR_MAX) {

Here below, the message is "announce accept limit greater than maximum". =

Should we keep only "limit greater than maximum"?

> @@ -723,10 +721,12 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct=
 genl_info *info)
>   	unsigned int rcv_addrs, subflows;
>   	int ret;
>   =

> +	rcv_addrs =3D pernet->add_addr_accept_max;

I guess that's fine to always call the two WRITE_ONCE() here below even =

if it is not needed, right?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4860016282912692855==--
