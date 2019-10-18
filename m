Content-Type: multipart/mixed; boundary="===============2100946196838017047=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: recvmsg refactor follow-up
Date: Fri, 18 Oct 2019 14:10:54 -0700
Message-ID: <alpine.OSX.2.21.1910181403150.15368@scellis-mobl.amr.corp.intel.com>
In-Reply-To: c57522143bb133d68fb75d1e3b5425858294563e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2238

--===============2100946196838017047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 18 Oct 2019, Paolo Abeni wrote:

> On Thu, 2019-10-17 at 15:31 -0700, Mat Martineau wrote:
>> This looks good for merging, based on patch review and some testing.
>
> Thank you for testing!
>
>> I did see some KASAN problems (not associated with these patches, I
>> think),
>
> Can you please share the kasan report? I'm not seeing them on top of
> current git.
>

This turns out to be the path manager bug I emailed the list about earlier =

today. There are a couple of bugs interacting there when no announce =

address is configured: pm->local_family is uninitialized, and =

the v4/v6 mptcp_pm_create_subflow functions don't handle the NULL addr.

Peter's working on a patch.

>> and lots of flushing of duplicate recv data when testing with
>> multipath-tcp.org v0.95.
>
> Who is flushing ?!? mptcp.org or net-next impl? if it's the latter .org
> is likely too aggressive in sending retransmission (or we looks too
> 'lazy' as we ack at MPTCP level only after recvmsg().

net-next. I was able to reproduce the behavior on one set of VMs (but not =

with a fresh build from today's export branch) - looks like it was a side =

effect of the crashed thread. We weren't sending DSS ACKs after the crash, =

so the peer kept resending.

--
Mat Martineau
Intel
--===============2100946196838017047==--
