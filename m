Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885B72
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 00:01:35 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mpJFX-0004ZL-QU; Tue, 23 Nov 2021 01:01:28 +0100
Date: Tue, 23 Nov 2021 01:01:27 +0100
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 2/2] selftests: mptcp: check IP_TOS in/out
 are the same
Message-ID: <20211123000127.GL6326@breakpoint.cc>
References: <20211122152651.28466-1-fw@strlen.de>
 <20211122152651.28466-2-fw@strlen.de>
 <7f24c515-6b41-e58a-6aba-c9f597c07cd1@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f24c515-6b41-e58a-6aba-c9f597c07cd1@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> > +static void init_rng(void)
> > +{
> > +	int fd = open("/dev/urandom", O_RDONLY);
> > +
> > +	if (fd >= 0) {
> > +		unsigned int foo;
> > +
> > +		/* can't fail */
> > +		(void)read(fd, &foo, sizeof(foo));
> > +
> > +		close(fd);
> > +		srand(foo);
> > +	} else {
> > +		srand(time(NULL));
> > +	}
> > +}
> 
> Do you think we need to modify the other ones in MPTCP selftests?

Probably best to add a followup patch that adds internal.h helpers
to reduce this copypastry.
