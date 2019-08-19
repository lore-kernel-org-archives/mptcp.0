Content-Type: multipart/mixed; boundary="===============2753453558434001340=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 6/6] mptcp: implement memory accounting for
 mptcp rtx queue
Date: Mon, 19 Aug 2019 13:47:42 +0200
Message-ID: <20190819114742.GG2588@breakpoint.cc>
In-Reply-To: e885fa778a668e8ef842ec18cb922f8a0edabbb1.1565970525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1656

--===============2753453558434001340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Charge the data on the rtx queue to the master MPTCP socket, too.
> Such memory in uncharged when the data is acked/dequeued.

Could you briefly explain why this is needed?
The data is already accounted on the subflows.

Under what circumstances is the data un-charged from a subflow,
but still retained on the mptcp retrans list?

--===============2753453558434001340==--
