Content-Type: multipart/mixed; boundary="===============6322979615741665722=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "tcp: coalesce/collapse must respect
 MPTCP extensions"
Date: Fri, 20 Dec 2019 10:29:45 -0800
Message-ID: <alpine.OSX.2.21.1912201027150.52347@mkavai-mobl.amr.corp.intel.com>
In-Reply-To: 7d8d66c1daa70ab3b70200ca33e5551427fadbab.1576866221.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3231

--===============6322979615741665722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Dec 2019, Paolo Abeni wrote:

> clarify mptcp ext usage
>
> to be added to squashed commit changelog:
> """
> v5 -> v6:
>  - clarify MPTCP must always be cleared at allocation time

"clarify MPTCP skb extensions must always be cleared at allocation time"

> """
> ---
> include/net/mptcp.h | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 7d693d0a38ff..8825da7538dd 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -48,6 +48,9 @@ static inline void mptcp_skb_ext_move(struct sk_buff *t=
o,
> static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
> 				     const struct mptcp_ext *from_ext)
> {
> +	/* MPTCP always clear the ext when adding it to the skb, so

s/clear/clears/

> +	 * holes do not bother us here
> +	 */
> 	return !from_ext ||
> 	       (to_ext && from_ext &&
> 	        !memcmp(from_ext, to_ext, sizeof(struct mptcp_ext)));
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============6322979615741665722==--
