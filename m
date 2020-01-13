Content-Type: multipart/mixed; boundary="===============2867944764817293971=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: add basic kselftest for mptcp"
Date: Mon, 13 Jan 2020 17:05:57 +0100
Message-ID: <15727d6eaf3ee36442eaf843da9e9f2bb49afdd6.camel@redhat.com>
In-Reply-To: 20200111011057.19143-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3346

--===============2867944764817293971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-10 at 17:10 -0800, Mat Martineau wrote:
> I was helping the LKP/0-day team with information on running our tests,
> and noticed some missing config options.
> =

> It looks like a toss-up between 'm' and 'y' for these, so I set values
> based on similar entries in tools/testing/selftests/net/config
> =

> Did I miss any others that aren't in the default config?

I *think* this should be enough. LGTM, thanks!

Paolo

--===============2867944764817293971==--
