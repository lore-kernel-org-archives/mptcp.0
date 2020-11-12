Content-Type: multipart/mixed; boundary="===============1478021168135928748=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP 0/5] mptcp: add reset and fastclose option
 support
Date: Thu, 12 Nov 2020 10:48:17 +0100
Message-ID: <20201112094817.GK23619@breakpoint.cc>
In-Reply-To: 9ca1f43c-105c-afb-3b99-383556309398@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6668

--===============1478021168135928748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> I had a couple of minor questions on patch 3, but nothing that would keep
> this from going in to the export branch for some more testing. Might be
> easier to coordinate with Paolo's refactor changes to the workqueue that
> way.
> =

> Do the selftests get any code coverage on this, for example in the
> new-subflow-not-allowed case?

How would you do that?  I could add a mib counter and check that in the
script.  But other than that I do not see how to expose any of this to
the script/mptcp_connect.

> And thanks for looking at packetdrill tests for this,
> saw the conversation on IRC.

Yes, I plan to send a pull request for fastclose and reset.

As for further direction, I think next step is to add genl notifications
so mptcpd can learn about subflows that are added/removed, the reset
code could then be exposed to userspace in the 'subflow was reset'
case.
--===============1478021168135928748==--
