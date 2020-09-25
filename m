Content-Type: multipart/mixed; boundary="===============8584837577043913424=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 13/16] selftests: mptcp: add
 remove addr and subflow test cases
Date: Thu, 24 Sep 2020 17:25:18 -0700
Message-ID: <alpine.OSX.2.23.453.2009241724440.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: e0f074f2764382c6aa1e901f3003455261a33da3.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6037

--===============8584837577043913424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2020, Geliang Tang wrote:

> This patch added the remove addr and subflow test cases and two new
> functions.
>
> The first function run_remove_tests calls do_transfer with two new
> arguments, rm_nr_ns1 and rm_nr_ns2, for the numbers of addresses should be
> removed during the transfer process in namespace 1 and namespace 2.
>
> If both these two arguments are 0, we do the join test cases with
> "mptcp_connect -j" command. Otherwise, do the remove test cases with
> "mptcp_connect -r" command.
>
> The second function chk_rm_nr checks the RM_ADDR related mibs's counters.
>
> The output of the test cases looks like this:
>
> 11 remove single subflow           syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   rm [ ok ] - sf    [ ok ]
> 12 remove multiple subflows        syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   rm [ ok ] - sf    [ ok ]
> 13 remove single address           syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   add[ ok ] - echo  [ ok ]
>                                   rm [ ok ] - sf    [ ok ]
> 14 remove subflow and signal       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   add[ ok ] - echo  [ ok ]
>                                   rm [ ok ] - sf    [ ok ]
> 15 remove subflows and signal      syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                   add[ ok ] - echo  [ ok ]
>                                   rm [ ok ] - sf    [ ok ]
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 145 +++++++++++++++++-
> 1 file changed, 142 insertions(+), 3 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============8584837577043913424==--
