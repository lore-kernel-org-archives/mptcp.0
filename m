Content-Type: multipart/mixed; boundary="===============9164292243860186587=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 25th of April 2019
Date: Thu, 02 May 2019 18:58:59 +0200
Message-ID: <384e78ed-6307-d975-e5c7-0b9d6c149f0a@tessares.net>
In-Reply-To: 20190502155303.er6eqhxw5n3libcs@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1111

--===============9164292243860186587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 02/05/2019 17:53, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> On Mon, 2019-04-29 at 11:02 -0700, Mat Martineau wrote:
>>> If we can merge the beginning of the patch set in our repo, I think it =

>>> will be much easier to coordinate our work by appending commits rather =

>>> than constantly revising the whole series. I think we're getting close =
to =

>>> that point, and after the pushing RFCv10 we may be in a good position t=
o =

>>> merge the earlier patches and then focus on new commits (or commits tha=
t =

>>> can be easily squashed).
>>
>> I agree with this kind of approach. I would take it to the extent of
>> accepting the patchset as is, and than handle whatever is needed with
>> incremental patches.
> =

> Also agree.  Squashing simple changes (test case improvements, spelling
> fixes and so on) is fine but for everything else I would prefer new commi=
ts.
> =

> There can be one larger rebase/squash effort once its decided that a
> netdev rfc submission is to be made.
> =

> Until then, constant rebasing is just a waste of time imo.
> =

> New commits-on-top would make it easier to track development too.
> =


Sorry, I just saw your email now and understood what Paolo and Mat were
saying about incremental patches: we can focus on new commits and rebase
later.

Anyway I guess it is easier if one person does that to avoid working on
a different base.
As I use to work with TopGit, I think it is not an issue for me to
maintain the code with this tool. If one fix is linked to one commit, I
can cherry-pick/apply the fix in the right topic. If not, I can also add
a new topic at the end. Except if you think using TopGit will create
more issues for you guys than it will solve?

Thanks,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============9164292243860186587==--
