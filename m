Content-Type: multipart/mixed; boundary="===============8066086596936601186=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 5/6] mptcp: use retransmission timer to update
 msk una
Date: Mon, 19 Aug 2019 13:44:55 +0200
Message-ID: <20190819114455.GF2588@breakpoint.cc>
In-Reply-To: 445d83af96a27730d5cf2c515115ac565ea31cdc.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1655

--===============8066086596936601186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> plugging unacked sequence update into sendmsg() is not enough;
> use the msk icsk retransmit timer to trigger una updates. The
> timer freqeuncy is based on the current subflow RTO estimation.

Looks fine to me, I think we will need the timer in any
case to trigger mptcp level retrans so might as well handle the
una update there as well.

--===============8066086596936601186==--
