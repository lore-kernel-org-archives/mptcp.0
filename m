Content-Type: multipart/mixed; boundary="===============4778442453509059157=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:pm netlink: fix variable scope
Date: Mon, 06 Apr 2020 10:38:42 -0700
Message-ID: <alpine.OSX.2.22.394.2004061035420.9267@rjpitkin-mobl.amr.corp.intel.com>
In-Reply-To: 20200406141931.134339-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4142

--===============4778442453509059157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 6 Apr 2020, Matthieu Baerts wrote:

> kbuild reported this warning from CPPCheck:
>
>    net/mptcp/pm_netlink.c:98:22: warning: The scope of the variable 'skc'=
 can be reduced. [variableScope]
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>    I tried to reproduce this warning with CPPCheck (1.90) but without suc=
cess.
>    Should I send this patch to netdev? In this function, it will not chan=
ge
>    anything, no?

Probably makes sense to send when net-next reopens, it's not a critical =

fix.


Mat


>
>    CPPCheck could also complain that 'cur' variable scope could be reduce=
d.
>
>    With CPPCheck, I only got false positive warnings in net/mptcp/protoco=
l.c:
>
>        Possible null pointer dereference: dfrag
>
>        net/mptcp/protocol.c:776:42: note: Calling function 'mptcp_sendmsg=
_frag', 4th argument 'NULL' value is 0
>          ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
>
>    It seems it doesn't understand "retransmision =3D !!dfrag". I don't kn=
ow if I
>    should add cppcheck support in the CI. For the moment, I would only ha=
ve to
>    suppress false positives :)
>
> net/mptcp/pm_netlink.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a0ce7f324499..3ad952affdcf 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -95,9 +95,10 @@ static bool lookup_subflow_by_saddr(const struct list_=
head *list,
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_addr_info cur;
> -	struct sock_common *skc;
>
> 	list_for_each_entry(subflow, list, node) {
> +		struct sock_common *skc;
> +
> 		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>
> 		local_address(skc, &cur);
> -- =

> 2.25.1
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============4778442453509059157==--
