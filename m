Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371772
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 10:18:25 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mkkgR-0001Ra-CZ; Wed, 10 Nov 2021 11:18:23 +0100
Date: Wed, 10 Nov 2021 11:18:23 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/3] selftests: mptcp: add TCP_INQ support
Message-ID: <20211110101823.GF16363@breakpoint.cc>
References: <20211108105711.16200-1-fw@strlen.de>
 <20211108105711.16200-3-fw@strlen.de>
 <634cff10-1c91-2a68-74cd-3c48da807528@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <634cff10-1c91-2a68-74cd-3c48da807528@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Mon, 8 Nov 2021, Florian Westphal wrote:
>=20
> > Do checks on the returned inq counter.
> > Fail on:
> > 1. Huge value (>=3D 1 megabyte, test case files are 1 MB)
> > 2. last hint larger than returned bytes when read was short
> > 3. erroenous indication of EOF.
> >=20
> > 3) happens when a hint of X bytes reads X-1 on next call
> >   but next recvmsg returns more data (instead of EOF).
> >=20
>=20
> Is it possible to do a more deterministic test? Like: one peer sends X
> bytes, other peer waits and then reads X-Y bytes, then checks that the inq
> value is Y?

Ok, will add a new mptcp_inq test instead of this one.
