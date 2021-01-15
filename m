Content-Type: multipart/mixed; boundary="===============8155829050797201918=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] selftests: mptcp: add
 command line arguments for mptcp_join.sh
Date: Thu, 14 Jan 2021 17:22:25 -0800
Message-ID: <53806e88-91c9-24c4-db15-6eae9ccf75@linux.intel.com>
In-Reply-To: 8c077beefbbe778c1055596fdfca323588fb9df8.1610602140.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7396

--===============8155829050797201918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Jan 2021, Geliang Tang wrote:

> Since the mptcp_join script is becoming too big, this patch split it into
> several smaller trunks, each of them has been defined in a function as a
> individual test group for several related testcases.
>
> Using bash getopts function to parse command line arguments, and involk

One very minor thing, maybe Matthieu could fix "invoke" in the line above =

when applying?

Otherwise, looks good to me.

Thanks,

Mat


> each function to do the individual test group.
>
> Here are all the arguments:
>  -f subflows_tests
>  -s signal_address_tests
>  -l link_failure_tests
>  -t add_addr_timeout_tests
>  -r remove_tests
>  -a add_tests
>  -6 ipv6_tests
>  -4 v4mapped_tests
>  -b backup_tests
>  -p add_addr_ports_tests
>  -c syncookies_tests
>  -h help
>
> Run mptcp_join.sh with no argument will do all the testcases.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v2:
> - rebase on export/20210113T185637
> - please apply this patchset after the following patchsets:
>    add IPv4-mapped address support (v5)
>    mptcp: create subflow for newly added address and testcases (v5)
>    ADD_ADDR: ports support (v10)
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 1068 +++++++++--------
> 1 file changed, 590 insertions(+), 478 deletions(-)
>

--
Mat Martineau
Intel
--===============8155829050797201918==--
