Content-Type: multipart/mixed; boundary="===============7154297845158983203=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 25th of April 2019
Date: Mon, 29 Apr 2019 11:02:14 -0700
Message-ID: <alpine.OSX.2.21.1904291053020.5723@mjmartin-mac01.local>
In-Reply-To: CAKuKrBm4xZ-9ci39YdOA1b_n+ug8aX9pnOQ+hRpoB6aNQxxbyw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1099

--===============7154297845158983203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2019, Matthieu Baerts wrote:

> Hi Paolo,
>
> On Mon, Apr 29, 2019 at 3:29 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
>>
>> Hi,
>>
>> On Thu, 2019-04-25 at 18:28 +0200, Matthieu Baerts wrote:
>>> Initial architecture:
>>>     - Paolo will do a new iteration of his fixes/improvement we
>>> discussed last week
>>
>> I think I'll wait for Mat's rework to post next iteration, to avoid
>> conflicts - unless others have different opinions.
>>
>> Apropos: keeping track of the pending patches is quite difficult for
>> me. Do others have similar issues?

This is an issue with the way we're doing things currently.

We've been making changes based on gerrit feedback across the patch set.
This creates a couple of challenges:

1: The information about what's getting fixed is spread across different
reviews in gerrit

2: Changing things early in the series involves the extra work of
resolving conflicts and testing throughout the series

It's definitely important to improve what we're doing to keep everyone =

informed about what is going on, and to make it easier to coordinate now =

that we have more contributors.

>>
>> I think/hope that a more incremental approach (merge the patches
>> eariler - especially bug-fixes - and ev. do follow-up if needed) could
>> simplify the situation. WDYT?
>
> I understand it is not easy to keep track.
> The original idea was to merge Mat & Peter's patch-set in our repo
> once they are accepted (+2) in Gerrit
> https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/448886/2
>
> Then we hope it will be easier and quicker to maintain these patches.
>
> Do you think we could go for this approach? Or do you think it will
> still be hard to keep track and maintain everything?
>

If we can merge the beginning of the patch set in our repo, I think it =

will be much easier to coordinate our work by appending commits rather =

than constantly revising the whole series. I think we're getting close to =

that point, and after the pushing RFCv10 we may be in a good position to =

merge the earlier patches and then focus on new commits (or commits that =

can be easily squashed).

--
Mat Martineau
Intel

--===============7154297845158983203==--
