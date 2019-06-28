Content-Type: multipart/mixed; boundary="===============3693169233555284970=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] LPC networking CfP: abstract: draft
Date: Fri, 28 Jun 2019 16:36:01 -0700
Message-ID: <alpine.OSX.2.21.1906281628420.54524@mjmartin-mac01.local>
In-Reply-To: 7aff5fc8-b7b1-cca1-190c-cc0af053238f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1455

--===============3693169233555284970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 7 Jun 2019, Matthieu Baerts wrote:

> Hello,
>
> Yesterday, we discussed options for a Linux Plumber's Conference
> networking track talk.
>
> Here is a first draft of an abstract. Feel free to comment and react:
>
> =3D=3D=3D
...
> =3D=3D=3D
>
> Do not hesitate to improve it, fix typo or restart from scratch if
> needed, I don't mind!
>

I edited and rewrote part of the draft to focus on the long-term roadmap =

and how we phase in features. The main audiences I'm thinking of are the =

maintainers and present users of the multipath-tcp.org kernel.

It's not ready for submission yet, but given our plan to submit =

mid-next-week I wanted to share a draft before the weekend:

"""
Multipath TCP (MPTCP) is an increasingly popular protocol that members of =

the kernel community are actively working to upstream. A Linux kernel fork =

implementing the protocol has been developed and maintained since March =

2009. While there are some large MPTCP deployments using this custom =

kernel, an upstream implementation will make the protocol available on =

Linux devices of all flavors.

MPTCP is closely coupled to TCP, but an implementation does not need to =

interfere with operation of normal TCP connections. Our roadmap for MPTCP =

in Linux begins with the server use case, where connections and additional =

subflows are generally initiated by peer devices. This will start with RFC =

6824 compliance, but with a minimal feature set to limit the code =

footprint for initial review and testing.

The MPTCP upstreaming community has shared a RFC patch set on the netdev =

list that shows our progress and how we plan to build around the TCP =

stack. We'll share our roadmap for how this patch set will evolve before =

final submission, and discuss how this first step will differ from the =

forked implementation.

Once we have merged our baseline code, we have plans to continue =

development of more advanced features for managing subflow creation (path =

management), scheduling outgoing packets across subflows, and other =

capabilities important for client devices that initiate connections. This =

includes making use of a userspace path manager, which has an alpha =

release available already. In future kernel releases we will make use of =

additional TCP features and optimize MPTCP performance as we get more =

feedback from kernel users.

Both the communication and the code are public and open. You can find us =

at mptcp(a)lists.01.org and https://is.gd/mptcp_upstream
"""


--
Mat Martineau
Intel

--===============3693169233555284970==--
