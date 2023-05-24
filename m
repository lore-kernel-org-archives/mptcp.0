Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6318C10
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 12:23:02 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q1nW4-0003lR-Ue; Wed, 24 May 2023 14:22:56 +0200
Date: Wed, 24 May 2023 14:22:56 +0200
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Message-ID: <20230524122256.GB12567@breakpoint.cc>
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
 <20230524095653.GD17561@breakpoint.cc>
 <477af94a-d47e-d0c2-ba42-285dc5597fa4@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <477af94a-d47e-d0c2-ba42-285dc5597fa4@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> > I added the "num_subflows_copied" for ease-of-use on userspace
> > side but I agree that its not required and userspace has
> > enough info to figure out which upper cap to use.
>=20
> If I understand properly, it means that num_subflows_user and _kern will
> only be used to know the size of the arrays:
>=20
> - num_subflows_user: size of the arrays in the buffer
> - num_subflows_kern: what has been written by the kernel, max _user

This is why I had the '_copied' in my proposal :-)

With only _user and _kern:

_user: size of the arrays in the buffer
_kern: subflow count of the kernel, i.e. can be larger than _user.

> I think it is still important to have somewhere a num_subflows field to
> know how many subflows are attached to an MPTCP connection (also for the
> userspace to know if it missed some info because it gave a too small
> buffer).

Yes, userspace must be able to infer that it only got partial
information due to lack of space.

E.g. if userspace expects a maximum amount of 16 subflows but connection
has 240 subflows then num_subflows_kern is 240 and _user is 16.

Userspace can only access up to 16 (since thats what it
provided/allocated).

The _copied proposal would have made this easier on userspace side
(_user is the allocated space, _kern what the kernel would like (real
count), and _copied what was written out).

But as Paolo said userspace can infer the valid count by checking
if _kern > _user, so it does:

bool truncated =3D kern > user;
subflows_copied =3D truncated ? user : kern;
