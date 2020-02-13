Content-Type: multipart/mixed; boundary="===============5473652380414433817=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] Squash-to: "mptcp: Implement path manager
 interface commands"
Date: Thu, 13 Feb 2020 12:54:12 +0100
Message-ID: <62d99523b475296ba37280556f42758fee300e60.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2002121726140.34444@echiprou-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3649

--===============5473652380414433817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 18:05 -0800, Mat Martineau wrote:
> +static bool mptcp_pm_work_pending(const struct mptcp_pm_data *pm)
> > +{
> > +	return (READ_ONCE(pm->local_addr_used) <
> > +		READ_ONCE(pm->local_addr_max)) ||
> > +	       (READ_ONCE(pm->add_addr_signaled) <
> > +		READ_ONCE(pm->add_addr_signal_max));
> > +}
> =

> It looks like these values are only modified under a lock, but are read =

> some of the time without a lock. If the values are concurrently modified =

> is it harmless? It would be helpful to have at least a comment explaining =

> the expected locking semantics.
> =

> Would it be overkill to pack the values that are compared (like =

> local_addr_used and local_addr_max) so they can be read & written =

> together?

Thank you for the feedback! I'm double minded about this READ_ONCE
stuff. I'd like to avoid lock osperation when possible but I agree the
current impl is ugly.

What if I a single 'work_pending' bool in 'struct mptcp_pm_data', let
pm_netlink WRITE_ONCE it as needed, and use it to replace the above
code?

Thanks,

Paolo

@Florian: addendum WRT bool vs u8:1 usage: I need 'bool' type to
{WRITE,READ}_ONCE. Are you ok if I keep using bool?

--===============5473652380414433817==--
