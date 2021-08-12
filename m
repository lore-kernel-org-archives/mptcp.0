Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C672
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 18:42:00 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mEFeK-0000nV-KB; Thu, 12 Aug 2021 20:41:52 +0200
Date: Thu, 12 Aug 2021 20:41:52 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/5] mptcp: add MPTCP_TCPINFO getsockopt
 support
Message-ID: <20210812184152.GE607@breakpoint.cc>
References: <20210811131523.6339-1-fw@strlen.de>
 <20210811131523.6339-4-fw@strlen.de>
 <265d1dc-7ea0-d55c-957f-8aa0eb53f094@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <265d1dc-7ea0-d55c-957f-8aa0eb53f094@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>=20
>=20
> On Wed, 11 Aug 2021, Florian Westphal wrote:
>=20
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index eba294a071c8..ac8e6823db4f 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -723,6 +723,96 @@ static int mptcp_getsockopt_info(struct mptcp_sock=
 *msk, char __user *optval, in
> >=20
> > 	if (copy_to_user(optval, &m_info, len))
> > 		return -EFAULT;
> > +	return 0;
> > +}
> > +
> > +static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
> > +				  char __user *optval, int __user *_u_optlen)
> > +{
> > +#define MIN_INFO_OPTLEN_SIZE	16
>=20
> This caught my eye on my first quick review pass, I'm not accustomed to
> seeing inline defines like this in the kernel unless it's part of some ma=
cro
> magic. The style guide / checkpatch don't say anything, so I'll just sugg=
est
> it would fit better outside the function scope (but no big deal).

An alternative would be to use 'sizeof struct mptcp_subflow_data' here
and change that structure a bit.

Instead of storing the size, add a 'version/flags' field.

That would also allow to extend the structure later: kernel would
expose a 'struct mptcp_subflow_data_v2' or similar if the need would
arise and userspace would tell kernel the size in indirect fashion by
setting a special 'v2 enabled' field.
