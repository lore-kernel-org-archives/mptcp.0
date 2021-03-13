Content-Type: multipart/mixed; boundary="===============8902308783519615586=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] selftests: mptcp: Restore packet capture
 option in join tests
Date: Sat, 13 Mar 2021 02:00:08 +0000
Message-ID: <
 <161560080803.26528.18408748749099031586.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210313004352.209906-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8144

--===============8902308783519615586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Fri, 12 Mar 2021 16:43:52 -0800 you wrote:
> The join self tests previously used the '-c' command line option to
> enable creation of pcap files for the tests that run, but the change to
> allow running a subset of the join tests made overlapping use of that
> option.
> =

> Restore the capture functionality with '-c' and move the syncookie test
> option to '-k'.
> =

> [...]

Here is the summary with links:
  - [net] selftests: mptcp: Restore packet capture option in join tests
    https://git.kernel.org/netdev/net/c/a673321aa74f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============8902308783519615586==--
