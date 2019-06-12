Content-Type: multipart/mixed; boundary="===============4664654861150340978=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP-API
Date: Tue, 11 Jun 2019 20:39:44 -0700
Message-ID: <B258872C-CA60-4B5A-AE36-4FBF3E114A60@apple.com>
In-Reply-To: alpine.OSX.2.21.1906111427170.13075@skshiu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1342

--===============4664654861150340978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

> On Jun 11, 2019, at 3:24 PM, Mat Martineau <mathew.j.martineau(a)linux.in=
tel.com> wrote:
> =

> =

> Hi Christoph and Leif,
> =

> On Tue, 11 Jun 2019, Christoph Paasch wrote:
> =

>> I am bringing up something that we already once discussed quite a while
>> back. Apache Traffic Server has an option to enable MPTCP (currently,
>> through the socket-option MPTCP_ENABLED that is exposed on the
>> multipath-tcp.org kernel). Leif (in CC) is the main contributor & mainta=
iner
>> of ATS.
>> =

>> Now, ATS will be doing a 9.0.0-release soon that will be the first relea=
se
>> with this MPTCP-option in the ATS-config.
>> =

>> We want to make sure that it would also work with the upcoming upstream =
MPTCP
>> implementation. So, we can easily make this use IPPROTO_MPTCP. However,
>> there currently isn't a 100% guarantee that the API is stable (as upstre=
am
>> might request changes).
>> =

>> So, we are wondering how we can do binary compatibility without having to
>> wait for MPTCP to land upstream. Could the MPTCP-code expose maybe a sys=
ctl
>> that indicates the "API-version" ? That way, upon startup ATS can simply
>> check the API-version and if it doesn't match, just disable MPTCP.
>> =

>> =

>> What are your thoughts?
> =

> There are a couple of approaches we could use to help ATS and other proje=
cts as upstream MPTCP evolves.
> =

> One is that we should pick a likely-to-get-merged value for IPPROTO_MPTCP=
. The current prototype uses 99, but the IANA defines that as "any private =
encryption scheme). We had earlier prototypes with 262 (IPPROTO_TCP | 0x100=
) since the socket API uses 'int proto' instead of a single byte. ATS could=
 consider a runtime-configurable proto value for MPTCP to help with this.

Yes, let's pick a "likely-to-get-merged" value ASAP. Do you think 262 could=
 work out?

> My impression is that the maintainers would not want a "MPTCP API version=
" sysctl where you'd read a number from a file and have v0, v1, v2 etc API =
since it would mainly exist to accomodate non-upstream kernels. The upstrea=
m API (once MPTCP is merged) is not supposed to change in ways that break u=
serspace, after all.
> =

> Given that the MPTCP features will get added to the upstream kernel over =
time, we may have an easier time justifying a MPTCP feature flag sysctl, ki=
nd of like the CPU flags in /proc/cpuinfo. That could indicate support for =
things like TFO, netlink path management, break-before-make, customizable s=
chedulers, etc. The combination of features may be enough for userspace pro=
grams to figure out if they can make use of that MPTCP implementation.

That sounds like a fine approach to me.

In general, I am wondering, how do userspace applications handle runtime fe=
ature-checking as they may be running on different kernels? Is it always a =
try-and-error approach?


Christoph




--===============4664654861150340978==--
