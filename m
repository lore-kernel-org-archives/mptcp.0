Content-Type: multipart/mixed; boundary="===============1402198628515005916=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/4] protocol.h:
 mptcp_subflow_get_map_offset arg can be const
Date: Tue, 05 Nov 2019 18:46:19 +0100
Message-ID: <b5c430c133f342ece192d1a3cfd07fe5bb196758.camel@redhat.com>
In-Reply-To: 20191105170531.30407-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2400

--===============1402198628515005916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-05 at 18:05 +0100, Florian Westphal wrote:
> squashto: mptcp: Implement MPTCP receive path
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8fe5f9383d38..46f7becd9a45 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -248,7 +248,7 @@ mptcp_subflow_tcp_socket(const struct mptcp_subflow_c=
ontext *subflow)
>  }
>  =

>  static inline u64
> -mptcp_subflow_get_map_offset(struct mptcp_subflow_context *subflow)
> +mptcp_subflow_get_map_offset(const struct mptcp_subflow_context *subflow)
>  {
>  	return tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied_seq -
>  		      subflow->ssn_offset -
> @@ -256,7 +256,7 @@ mptcp_subflow_get_map_offset(struct mptcp_subflow_con=
text *subflow)
>  }
>  =

>  static inline u64
> -mptcp_subflow_get_mapped_dsn(struct mptcp_subflow_context *subflow)
> +mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
>  {
>  	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
>  }

All the 4 patches LGTM, thanks Florian!

/P

--===============1402198628515005916==--
