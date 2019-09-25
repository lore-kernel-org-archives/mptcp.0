Content-Type: multipart/mixed; boundary="===============7575471072426762089=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix retransmit timer update
Date: Wed, 25 Sep 2019 10:28:35 -0700
Message-ID: <alpine.OSX.2.21.1909251026520.26111@leoliu1-mobl.amr.corp.intel.com>
In-Reply-To: fdc843af-48e8-8b9a-9abf-d4c86bb21c47@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1930

--===============7575471072426762089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 25 Sep 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 23/09/2019 13:49, Paolo Abeni wrote:
>> Mat noted the current code access ssk data outside the relevant
>> socket lock. Fix that moving the update in such scope
>
> Is this modification still OK for you? :)
>

Yes, mptcp_set_timeout() was not modifying the timeout in the "goto =

reset_unlock" case. This fix looks good.

--
Mat Martineau
Intel

--===============7575471072426762089==--
