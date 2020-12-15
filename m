Content-Type: multipart/mixed; boundary="===============6196800060689504047=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/9] mptcp: Another set of miscellaneous
 MPTCP fixes
Date: Tue, 15 Dec 2020 01:51:04 +0000
Message-ID: <
 <160799706497.8846.3593836390503051441.git-patchwork-notify@kernel.org>>
In-Reply-To: 20201210222506.222251-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7167

--===============6196800060689504047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 10 Dec 2020 14:24:57 -0800 you wrote:
> This is another collection of MPTCP fixes and enhancements that we have
> tested in the MPTCP tree:
> =

> Patch 1 cleans up cgroup attachment for in-kernel subflow sockets.
> =

> Patches 2 and 3 make sure that deletion of advertised addresses by an
> MPTCP path manager when flushing all addresses behaves similarly to the
> remove-single-address operation, and adds related tests.
> =

> [...]

Here is the summary with links:
  - [net-next,1/9] mptcp: attach subflow socket to parent cgroup
    https://git.kernel.org/bpf/bpf-next/c/3764b0c5651e
  - [net-next,2/9] mptcp: remove address when netlink flushes addrs
    https://git.kernel.org/bpf/bpf-next/c/141694df6573
  - [net-next,3/9] selftests: mptcp: add the flush addrs testcase
    https://git.kernel.org/bpf/bpf-next/c/6fe4ccdc3dab
  - [net-next,4/9] mptcp: use MPTCPOPT_HMAC_LEN macro
    https://git.kernel.org/bpf/bpf-next/c/ba34c3de71ce
  - [net-next,5/9] mptcp: hold mptcp socket before calling tcp_done
    https://git.kernel.org/bpf/bpf-next/c/ab82e996a1fa
  - [net-next,6/9] tcp: parse mptcp options contained in reset packets
    https://git.kernel.org/bpf/bpf-next/c/049fe386d353
  - [net-next,7/9] mptcp: parse and act on incoming FASTCLOSE option
    https://git.kernel.org/bpf/bpf-next/c/50c504a20a75
  - [net-next,8/9] mptcp: pm: simplify select_local_address()
    https://git.kernel.org/bpf/bpf-next/c/1bc7327b5fea
  - [net-next,9/9] mptcp: let MPTCP create max size skbs
    https://git.kernel.org/bpf/bpf-next/c/15e6ca974b14

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============6196800060689504047==--
