Content-Type: multipart/mixed; boundary="===============7170132085295446752=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 6/9] mptcp: refactor shutdown and close
Date: Tue, 29 Sep 2020 13:14:50 +0200
Message-ID: <eb41d883e6036907c2413a2c7dd66da84fddc48f.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2009281737370.6674@kemeng-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6094

--===============7170132085295446752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-28 at 18:08 -0700, Mat Martineau wrote:
> +	 * the ssk has been already destroyed, we just need to release the
> > +	 * reference owned by msk;
> > +	 */
> > +	if (!inet_csk(ssk)->icsk_ulp_ops) {
> > +		kfree_rcu(subflow, rcu);
> =

> icsk_ulp_ops might have been cleared for fallback sockets, is that an =

> expected case here too?

modulo bugs, we clear ULP only when accepting new connection, and in
that case we end-up with a real, plain TCP socket, so we should not
enter this code-path. So the above should be safe.

I'll include your other feedback in the next iteration - to be posted
after some more testing - thanks!

/P



--===============7170132085295446752==--
