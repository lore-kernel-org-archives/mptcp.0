Content-Type: multipart/mixed; boundary="===============7458839208374560508=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 26th of July 2018
Date: Fri, 27 Jul 2018 17:15:33 -0700
Message-ID: <alpine.OSX.2.21.1807271707040.6925@mmsebot-mobl.amr.corp.intel.com>
In-Reply-To: a5dcf79f-e1b6-cdb2-59e2-8d8001ec16e7@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 690

--===============7458839208374560508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 26 Jul 2018, Matthieu Baerts wrote:

> Netdev's debriefing:
>    - we got good feedbacks:
>        - people want to have MPTCP upstream and are supportive (Tom
> Herbert and Eric Dumazet)
>        - some concerns about not modifying binaries and still use MPTCP
> (without LD_PRELOAD), something possible with mptcp_trunk.
>        - there were some discussions/reminders about using per cgroups
> ebpf hooks (e.g. for API extension):
>            - BPF/netdev background:
> http://vger.kernel.org/netconf2018_files/AlexeiStarovoitov_netconf2018.pdf

Regarding this BPF / cgroup idea (thank you, David Ahern), here's a link =

to similar functionality implemented for the connect() call:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd74bad4e74ee373787a9ae24197c17b7cdc428d5

The equivalent would be something that could run early to override the =

proto value (or any other parameters) for any socket() call in a =

particular cgroup.

BPF_CGROUP_INET_SOCK_CREATE exists, but it runs at the end of =

inet_create() (too late to override the protocol).

--
Mat Martineau
Intel OTC

--===============7458839208374560508==--
