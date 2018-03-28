Content-Type: multipart/mixed; boundary="===============6708460076318939692=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Socket layer changes to MPTCP
Date: Wed, 28 Mar 2018 14:39:43 -0700
Message-ID: <alpine.OSX.2.21.1803281344420.16850@fmorale1-mobl2.amr.corp.intel.com>
In-Reply-To: fb9eaa79-5284-8ec7-b8ce-688d567be143@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 441

--===============6708460076318939692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao -

On Wed, 28 Mar 2018, Rao Shoaib wrote:

> I have recently noticed that the group is working on socket level =

> changes to MPTCP.
>
> Can a summary of the issues and how the changes will solve them be =

> posted to the list?=C2=A0 That would help any new participants as well. I=
f =

> they have already been discussed please point me to the thread.

I proposed moving away from the metasocket architecture last summer:
https://lists.01.org/pipermail/mptcp/2017-July/000064.html

When I reviewed the multipath-tcp.org implementation of MPTCP, my =

assessment was (and is) that using metasockets resulted in more intrusive =

code changes for TCP. The more partitioned approach of KCM and RDS (using =

internal kernel sockets) shows an example of in-kernel features that the =

maintainers have merged. The approach seemed feasible and I proposed it as =

a direction to go.

> It will also help if it can be made clear how these changes will =

> expedite implementation of a basic MPTCP implementation. I believe that =

> is the current goal, but my understanding may be incorrect.

I think it will expedite upstreaming in the sense that metasockets would =

never get merged upstream, and that a more partitioned approach with =

dedicated subflow sockets has a reasonable shot. That's my opinion based =

on what I've seen from the maintainers (in terms of mailing list =

discussions, conversations, and what they have merged in the past).

Now, Christoph has raised the topic for more detailed discussion with =

regard to the specifics of the multipath-tcp.org implementation. I don't =

think anything is a foregone conclusion in terms of this aspect of the =

upstreaming project, you can propose a different approach to discuss.


Thanks,

--
Mat Martineau
Intel OTC

--===============6708460076318939692==--
