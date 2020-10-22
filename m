Content-Type: multipart/mixed; boundary="===============4615128842052046625=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] selftests: mptcp: depends on built-in IPv6
Date: Wed, 21 Oct 2020 20:43:21 -0700
Message-ID: <20201021204321.144e6df4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 1d28e7da-3fce-b064-a159-662f53e5a3b@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6401

--===============4615128842052046625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Oct 2020 17:35:32 -0700 (PDT) Mat Martineau wrote:
> > Recently, CONFIG_MPTCP_IPV6 no longer selects CONFIG_IPV6. As a
> > consequence, if CONFIG_MPTCP_IPV6=3Dy is added to the kconfig, it will =
no
> > longer ensure CONFIG_IPV6=3Dy. If it is not enabled, CONFIG_MPTCP_IPV6
> > will stay disabled and selftests will fail.
> >
> > We also need CONFIG_IPV6 to be built-in. For more details, please see
> > commit 0ed37ac586c0 ("mptcp: depends on IPV6 but not as a module").
> >
> > Note that 'make kselftest-merge' will take all 'config' files found in
> > 'tools/testsing/selftests'. Because some of them already set
> > CONFIG_IPV6=3Dy, MPTCP selftests were still passing. But they will fail=
 if
> > MPTCP selftests are launched manually after having executed this command
> > to prepare the kernel config:
> >
> >  ./scripts/kconfig/merge_config.sh -m .config \
> >      ./tools/testing/selftests/net/mptcp/config
> >
> > Fixes: 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 instead o=
f selecting it")
> > Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Applied, thank you!
--===============4615128842052046625==--
