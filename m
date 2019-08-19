Content-Type: multipart/mixed; boundary="===============0806506625797856710=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 3/6] mptcp: update msk unacked sequence in
 sendmsg()
Date: Mon, 19 Aug 2019 13:09:27 +0200
Message-ID: <20190819110927.GD2588@breakpoint.cc>
In-Reply-To: 165e8c8bb1924963f285a6025e7582487758c561.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1653

--===============0806506625797856710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> +	/* heuristic to avoid doing the expensive data ack update frequently */
> +	if (snd_una + tcp_sk(sk)->snd_cwnd <=3D msk->write_seq)
> +		snd_una =3D mptcp_update_msk_una(sk);

I think this will need to protect against sequence wraparound.

> +	/* if we msk just switched to this subflow, update subflow's una
> +	 * to allow 32 bit ack update to be more accurate
> +	 */
> +	subflow =3D subflow_ctx(ssk);
> +	if (after64(snd_una, subflow->snd_una))
> +		subflow->snd_una =3D snd_una;

... like you did here.

--===============0806506625797856710==--
