Content-Type: multipart/mixed; boundary="===============8575217991097299782=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Restructuring of TCP code for implementing MPTCP
Date: Fri, 09 Mar 2018 15:01:48 -0800
Message-ID: <cba72947-007a-2312-aaf7-feb90b71a2e4@oracle.com>
In-Reply-To: alpine.OSX.2.21.1803091355420.2360@msottenb-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 361

--===============8575217991097299782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/09/2018 02:19 PM, Mat Martineau wrote:
>
> Hi Rao -
>
> On Thu, 22 Feb 2018, Rao Shoaib wrote:
>
>> Hi Folks,
>>
>> When we met with David Miller and Eric Dumazet about a year ago to =

>> discuss how to include MPTCP in the main Linux distribution, they =

>> wanted to have some code that could be evaluated and used at the =

>> basis for discussion.
>>
>> The patches that I have submitted are for starting that discussion =

>> only and nothing else. If the approach is acceptable we can do more =

>> cleanup, If not we will have a discussion and hopefully agree on =

>> something.
>>
>> I would like to send the patches, perhaps a week from now to the =

>> netdev mailing list to start a discussion there and come up with a =

>> plan to implement MPTCP.
>>
>> Comments/Suggestions ?
>>
>
> I saw that you posted some questions on netdev this week and got some =

> maintainer feedback: https://marc.info/?t=3D152039384300002&r=3D1&w=3D2
>
> David mentions:
>
> """
> Indirect calls are terrible and we are now looking at ways in which
> we can remove them from as many parts of the networking as possible.
> """
>
Yes against all objections I did post to net-dev and got some very =

informative answers. David is not allowing indirect function calls =

because of the security issues. You should see the comments that Linus =

has made about the fixes and folks asking for an alternative as they are =

heavily used.

https://www.theregister.co.uk/2018/01/22/intel_spectre_fix_linux/

> It's not immediately clear which techniques are being looked at (and =

> both Eric and David did not elaborate when you followed up). I'm =

> trying to find out which alternatives he's referring to - anyone else =

> seen information on this?
Nope. It's not clear what the solution will be, but that should not have =

any impact on the patch that we submitted. As a simple fix we can add =

if/else as there are only two ways to go.

Please see my email and comment.

Rao.

> Regards,
>
> -- =

> Mat Martineau
> Intel OTC


--===============8575217991097299782==--
