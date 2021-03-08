Content-Type: multipart/mixed; boundary="===============0170616834658341044=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: launch
 mptcp_connect with timeout"
Date: Mon, 08 Mar 2021 11:23:20 +0100
Message-ID: <7049c3e9920228c47a74d2b7d58910c9d5ca57f0.camel@redhat.com>
In-Reply-To: 20210308101627.2161839-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 8071

--===============0170616834658341044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-03-08 at 11:16 +0100, Matthieu Baerts wrote:
> In diag.sh, we want to send signals to mptcp_connect instances that have
> been started in the netns. But we cannot send this signal to 'timeout'
> otherwise that will stop the timeout and print something like:
> =

>   # ./diag.sh: line 1: 9536 Done echo a
>   # 9537 User defined signal 1 | timeout ${timeout_test} ip netns (...)
> =

> Instead of trying to find the right PID and storing them in an array, we
> can simply use the output of 'ip netns pids' and send a signal to all
> these PIDs.
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "selftests: mptcp: launch mptcp_connect with timeou=
t"

Nice cleanup! LGTM!

Thanks!

Paolo

--===============0170616834658341044==--
