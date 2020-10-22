Content-Type: multipart/mixed; boundary="===============2055034791377998648=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] selftests: mptcp: depends on built-in IPv6
Date: Wed, 21 Oct 2020 17:35:32 -0700
Message-ID: <1d28e7da-3fce-b064-a159-662f53e5a3b@linux.intel.com>
In-Reply-To: 20201021155549.933731-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6399

--===============2055034791377998648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Oct 2020, Matthieu Baerts wrote:

> Recently, CONFIG_MPTCP_IPV6 no longer selects CONFIG_IPV6. As a
> consequence, if CONFIG_MPTCP_IPV6=3Dy is added to the kconfig, it will no
> longer ensure CONFIG_IPV6=3Dy. If it is not enabled, CONFIG_MPTCP_IPV6
> will stay disabled and selftests will fail.
>
> We also need CONFIG_IPV6 to be built-in. For more details, please see
> commit 0ed37ac586c0 ("mptcp: depends on IPV6 but not as a module").
>
> Note that 'make kselftest-merge' will take all 'config' files found in
> 'tools/testsing/selftests'. Because some of them already set
> CONFIG_IPV6=3Dy, MPTCP selftests were still passing. But they will fail if
> MPTCP selftests are launched manually after having executed this command
> to prepare the kernel config:
>
>  ./scripts/kconfig/merge_config.sh -m .config \
>      ./tools/testing/selftests/net/mptcp/config
>
> Fixes: 010b430d5df5 ("mptcp: MPTCP_IPV6 should depend on IPV6 instead of =
selecting it")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> tools/testing/selftests/net/mptcp/config | 1 +
> 1 file changed, 1 insertion(+)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2055034791377998648==--
