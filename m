Content-Type: multipart/mixed; boundary="===============0009054267120060607=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 4/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 21:37:54 +0200
Message-ID: <20190615193754.hmqmi6u7ik4lh2qn@breakpoint.cc>
In-Reply-To: 20190615105259.15151-5-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1402

--===============0009054267120060607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
  =

>  static inline bool mptcp_syn_options(struct sock *sk, unsigned int *size,
> -				     struct mptcp_out_options* opts)
> +				     struct mptcp_out_optionsi *opts)

I don't think you wanted to append that 'i' here :-)

--===============0009054267120060607==--
