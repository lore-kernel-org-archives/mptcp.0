Content-Type: multipart/mixed; boundary="===============3013359709593785218=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 0/5] mptcp: add reset and fastclose option
 support
Date: Wed, 11 Nov 2020 17:44:28 -0800
Message-ID: <9ca1f43c-105c-afb-3b99-383556309398@linux.intel.com>
In-Reply-To: 20201105170126.5627-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6664

--===============3013359709593785218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 5 Nov 2020, Florian Westphal wrote:

> This series adds reset and fast close options.
> Both need common infrastructure:
> 1. need to parse mptcp option in tcp reset packets, and making
>    them available to the stack
> 2. ability to add mptcp option to tcp reset packets
>
> First two patches move code around and add mptcp-callsite for
> option deciding from rst packets.
>
> Patch 3 adds reset support (both decoding and adding them).
> Patch 4 adds the fastclose receive processing.
> Patch 5 sends a fastclose packet when userspace calls close()
> while there is unread data in the mptcp rx queue.
>
> Patch 2) is not strictly need ATM, I could rework the series
> to remove it and only handle fastclose for the time being.
> Last patch could be removed as well so we only handle the rx case
> (there is nothing in RFC that says we must send fastclose).
>
> Comments welcome.

I had a couple of minor questions on patch 3, but nothing that would keep =

this from going in to the export branch for some more testing. Might be =

easier to coordinate with Paolo's refactor changes to the workqueue that =

way.

Do the selftests get any code coverage on this, for example in the =

new-subflow-not-allowed case? And thanks for looking at packetdrill tests =

for this, saw the conversation on IRC.

--
Mat Martineau
Intel
--===============3013359709593785218==--
