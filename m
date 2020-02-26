Content-Type: multipart/mixed; boundary="===============1306242665473073206=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 20th of February 2020
Date: Wed, 26 Feb 2020 11:42:06 -0800
Message-ID: <alpine.OSX.2.22.394.2002261031570.50710@tvtrimel-mobl2.amr.corp.intel.com>
In-Reply-To: 815ae65b-cab1-5685-eaba-979182655895@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3814

--===============1306242665473073206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 21 Feb 2020, Matthieu Baerts wrote:

> 1233648: Needs Review / ACK: [RFC,1/3] mptcp: Check connection state bef
> 1233650: Needs Review / ACK: [RFC,2/3] mptcp: Use per-subflow storage fo
> 1233649: Needs Review / ACK: [RFC,3/3] mptcp: Only send DATA_FIN with f:
>    - *need review* (for more than one week)

This is old enough now that I need to rebase it.

> 1237722: New: [net,v2,1/3] mptcp: Keep TCP fallback subflow valid after
> 1237721: New: [net,v2,3/3] mptcp: Use TCP sendmsg/recvmsg for fallback:
>    - patch 2/3 has been upstreamed
>    - Paolo's understanding is that they are no longer needed
>    - *Mat* : can you confirm please?

That's correct - these aren't needed. I've archived them in patchwork.


>    - new about Intel's kbuild? (to check next week with Mat)

The kbuild team has been busy addressing other tasks, but they said I =

could submit a pull request to have them build the export branch. I will =

set that up to report results to mptcp(a)lists.01.org . Further =

configuration may be needed to have the self tests run, I will ask about =

that in the pull request.


--
Mat Martineau
Intel
--===============1306242665473073206==--
