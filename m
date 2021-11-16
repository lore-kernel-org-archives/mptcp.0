Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA22C82
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 23:21:33 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mn7lY-0005wX-Ae; Wed, 17 Nov 2021 00:21:28 +0100
Date: Wed, 17 Nov 2021 00:21:28 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 4/4] selftests: mptcp: add inq test case
Message-ID: <20211116232128.GG6326@breakpoint.cc>
References: <20211116134804.30090-1-fw@strlen.de>
 <20211116134804.30090-5-fw@strlen.de>
 <8efe4040-1e8f-4dd-3ec-9be2c6a46213@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8efe4040-1e8f-4dd-3ec-9be2c6a46213@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > +static void connect_one_server(int fd, int unixfd)
> > +{
> > +	size_t len, i, total, sent;
> > +	char buf[4096], buf2[4096];
> > +	int queued, on =3D 1;
>=20
> Still getting the 'unused variable' warnings on this line, but we can squ=
ash
> a fix for that (or wait to apply just this last patch?).

Sigh.  Mathieu, can you zap the line above (queued, on) after applying &
squash this?
