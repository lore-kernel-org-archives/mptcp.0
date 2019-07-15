Content-Type: multipart/mixed; boundary="===============3728722508965545911=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Mon, 15 Jul 2019 13:18:29 -0700
Message-ID: <CAPyD+=BAxk=qHKJ8nNHSwPeUshUxomizPpTGhNREHUjLFKn=QQ@mail.gmail.com>
In-Reply-To: 178bac59-10f1-8e1a-63a3-97286aca37ae@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1494

--===============3728722508965545911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Mon, Jul 15, 2019 at 11:44 AM Matthieu Baerts
<matthieu.baerts(a)tessares.net> wrote:
> On 15/07/2019 20:17, Othman, Ossama wrote:
> > Hi Matthieu,
> >
> > On Thu, Jul 11, 2019 at 12:01 PM Matthieu Baerts
> > <matthieu.baerts(a)tessares.net> wrote:
> >> For security reasons, it is interesting to have a global switch for
> >> MPTCP. To start, MPTCP will be disabled by default and only privileged
> >> users will be able to modify this. The reason is that because MPTCP is
> >> new, it will not be tested and reviewed by many and security issues can
> >> then take time to be discovered and fixed.
> >
> > Do we need to be concerned about this new sysctl variable being used
> > to maliciously enable or disable MPTCP?
>
> I am sorry, I don't understand your question?
>
> The goal would be to add a new sysctl variable as a global "safeguard".
> The application will continue to explicitly ask for MPTCP using
> IPPROTO_MPTCP.

I understand the safeguard purpose of the net.mptcp.enabled sysctl
variable.  It would indeed be useful as a means for a system
administrator to disable MPTCP without a reboot in the event a
security issue in MPTCP is identified.

My point was that it also introduces a way for compromised privileged
processes to potentially (and possibly inadvertently) disable MPTCP at
run-time without involving system administrators.  Admittedly, there
doesn't appear to be much reason for such compromised processes to do
that.   At the very least, I think it might be useful to verify that
the process in question has the CAP_NET_ADMIN capability when
modifying this variable.

Perhaps I'm being overly paranoid.  :)

> > According to the socket(2) man page, EINVAL might be the better errno:
> >
> >        EINVAL Unknown protocol, or protocol family not available.
>
> I didn't read the socket manpage, I should have done that :)
>
> I would prefer not to return EINVAL as it is already returned if the
> protocol is unknown, e.g. if the kernel does not support MPTCP.
> From an application point of view, I think it could be interesting to
> know if the kernel supports MPTCP or if MPTCP is "not allowed". I would
> like to say that this new error is reported not because "the protocol
> family is not available" but somehow, "not allowed" (EPERM?) to use it
> if you see what I mean :)

Yes, I see what you mean now. :)

> But maybe this is not needed? Or recommended to anyway return EINVAL.

Based on your intent, EPERM seems like a better fit, but either errno
works for me.

> > Should we prevent root processes that don't have the CAP_NET_ADMIN
> > capability from setting net.mptcp.enabled, e.g. something like the
> > following proc_dointvec() wrapper:
>
> I don't know what are the best practices for that. But I am happy to
> change if needed.

I guess it really depends on how paranoid we want to be.

-Ossama

--===============3728722508965545911==--
