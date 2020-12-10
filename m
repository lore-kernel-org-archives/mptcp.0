Content-Type: multipart/mixed; boundary="===============2727991541298803766=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 10th of December 2020
Date: Thu, 10 Dec 2020 14:18:35 -0800
Message-ID: <58bc15d2-a3cf-5b4b-2514-3c10f8ddbb4e@linux.intel.com>
In-Reply-To: 7028988d-259f-fc99-4da2-5939c7720e90@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7126

--===============2727991541298803766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 10 Dec 2020, Matthieu Baerts wrote:

> Patches to send to netdev:
>    - net:
>        - /
>
>    - net-next:
>        - See below: =E2=86=93
>        - Mat can send them
>        - Paolo will send independently the SELinux patch because it will =
go =

> to different tree/ML
>
> 58f1c48d7bbd bpf: expose is_mptcp flag to bpf_tcp_sock =E2=86=92 no
>
> f57f3b5446bb mptcp: attach subflow socket to parent cgroup =E2=86=92 yes
>
> e1a05f57895d bpf: add 'bpf_mptcp_sock' structure and helper =E2=86=92 no
> 921a342fed73 bpf:selftests: add MPTCP test base =E2=86=92 no
> eea7e1d5a580 bpf:selftests: add bpf_mptcp_sock() verifier tests =E2=86=92=
 no
>
> d27ed1c635bb mptcp: remove address when netlink flushes addrs =E2=86=92 y=
es
> 93713a3225de selftests: mptcp: add the flush addrs testcase =E2=86=92 yes
> 5c5e588b0e93 mptcp: use MPTCPOPT_HMAC_LEN macro =E2=86=92 yes
> dd635e51b7e0 mptcp: hold mptcp socket before calling tcp_done =E2=86=92 y=
es
> 99b4323a4bd4 tcp: parse mptcp options contained in reset packets =E2=86=
=92 yes

Matthieu, note that I'm modifying your "Reviewed-by" tag on this single =

patch ("tcp: parse mptcp options...") to "Acked-by" since the affected =

files are maintained by others.

> 815187eaa4c5 mptcp: parse and act on incoming FASTCLOSE option =E2=86=92 =
yes
> 62253eedfcee mptcp: pm: simplify select_local_address() =E2=86=92 yes
> 205c9df9ee33 mptcp: let MPTCP create max size skbs =E2=86=92 yes
>
> 20519a8c3383 mptcp: push pending frames when subflow has free space =E2=
=86=92 no:
>    - can be seen as a fix, we can wait
>

--
Mat Martineau
Intel

--===============2727991541298803766==--
