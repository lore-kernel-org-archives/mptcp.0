Content-Type: multipart/mixed; boundary="===============7571733813035155635=="
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH bpf-next v3 3/5] bpf: add 'bpf_mptcp_sock'
 structure and helper
Date: Mon, 21 Sep 2020 21:08:30 -0700
Message-ID: <20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: 20200918121046.190240-3-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5977

--===============7571733813035155635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 02:10:42PM +0200, Nicolas Rybowski wrote:
> +
> +BPF_CALL_1(bpf_mptcp_sock, struct sock *, sk)
> +{
> +	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP && sk_is_mptc=
p(sk)) {
> +		struct mptcp_subflow_context *mptcp_sfc =3D mptcp_subflow_ctx(sk);

Could you add !sk check here as well?
See commit 8c33dadc3e0e ("bpf: Bpf_skc_to_* casting helpers require a NULL =
check on sk")
It's not strictly necessary yet, but see below.

Also this new helper is not exercised from C test. Only from asm.
Could you update patch 4 with such additional logic?

> +
> +		return (unsigned long)mptcp_sfc->conn;

I think we shouldn't extend the verifier with PTR_TO_MPTCP_SOCK and similar=
 concept anymore.
This approach doesn't scale and we have better way to handle such field acc=
ess with BTF.

> +	}
> +	return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_mptcp_sock_proto =3D {
> +	.func           =3D bpf_mptcp_sock,
> +	.gpl_only       =3D false,
> +	.ret_type       =3D RET_PTR_TO_MPTCP_SOCK_OR_NULL,

In this particular case you can do:
+	.ret_type       =3D RET_PTR_TO_BTF_ID_OR_NULL,

Then bpf_mptcp_sock_convert_ctx_access() will no longer be necessary
and bpf prog will be able to access all mptcp_sock fields right away.
Will that work for your use case?
--===============7571733813035155635==--
