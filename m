Content-Type: multipart/mixed; boundary="===============5322289199145155750=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Mon, 27 Jul 2020 18:23:57 +0200
Message-ID: <20200727162357.GA8022@lst.de>
In-Reply-To: CAHmME9ric=chLJayn7Erve7WBa+qCKn-+Gjri=zqydoY6623aA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5326

--===============5322289199145155750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 06:16:32PM +0200, Jason A. Donenfeld wrote:
> Maybe sockptr_advance should have some safety checks and sometimes
> return -EFAULT? Or you should always use the implementation where
> being a kernel address is an explicit bit of sockptr_t, rather than
> being implicit?

I already have a patch to use access_ok to check the whole range in
init_user_sockptr.
--===============5322289199145155750==--
