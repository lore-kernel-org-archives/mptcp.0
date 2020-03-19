Content-Type: multipart/mixed; boundary="===============6947099634914483220=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Additional part 3 squash suggestion
Date: Fri, 20 Mar 2020 00:34:17 +0100
Message-ID: <20200319233417.GA3305@breakpoint.cc>
In-Reply-To: alpine.OSX.2.22.394.2003191614420.3820@sugandh1-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4001

--===============6947099634914483220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> =

> Florian and Matthieu -
> =

> From the meeting notes, it looks like "subflow: place further subflows on
> new 'join_list'" is the commit that you're planning to squash.
> =

> What do you think about also squashing "mptcp: increment MIB counters in a
> few places" in to the previous MIB commit? Seems like our patch count for
> part 3 is still kind of high.

SGTM.  We could change the commit title as follows:

- mptcp: add MIB counter infrastructure
+ mptcp: add and use MIB counter infrastructure

and toss the commit description of the 'increment MIB' patch,
it doesn't add any value.
--===============6947099634914483220==--
