Content-Type: multipart/mixed; boundary="===============6266579443565037106=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] MAINTAINERS: Add MPTCP maintainer
Date: Fri, 06 Dec 2019 22:22:40 +0100
Message-ID: <6d3e069f-8f96-db7f-e7c6-c1ebc66fda78@tessares.net>
In-Reply-To: 20191205230601.21396-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2834

--===============6266579443565037106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 06/12/2019 00:05, Mat Martineau wrote:
> When we discussed maintainership in an earlier meeting
> (https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/HCII262=
2GWZCOMQCBOMQBJKZI247YIH5/)
> there was a loose consensus that it would be best to have multiple
> maintainers. I nominate Matthieu Baerts <matthieu.baerts(a)tessares.net>
> as a co-maintainer, what do you think?
> =

> squashto: mptcp: Add MPTCP to skb extensions
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> =

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8608724835dd..0576b17abd44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11538,6 +11538,12 @@ F:	net/ipv6/calipso.c
>   F:	net/netfilter/xt_CONNSECMARK.c
>   F:	net/netfilter/xt_SECMARK.c
>   =

> +NETWORKING [MPTCP]
> +M:	Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> +L:	netdev(a)vger.kernel.org

I see that some have two mailing-lists with a note.

   L:	mptcp(a)lists.01.org (moderated for non-subscribers)

Can we not do the same?

Should we not also add these ones?

   Q:	https://patchwork.ozlabs.org/project/mptcp/list/
   W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
   T:	git git://github.com/multipath-tcp/mptcp_net-next.git
   B:	https://github.com/multipath-tcp/mptcp_net-next/issues

(not sure about the last one)

Also it is not linked to this but do you think at some points we should =

add some Documentations?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6266579443565037106==--
