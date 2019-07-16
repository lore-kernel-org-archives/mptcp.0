Content-Type: multipart/mixed; boundary="===============1337923528842892513=="
MIME-Version: 1.0
From: Othman, Ossama <ossama.othman at intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Tue, 16 Jul 2019 10:45:21 -0700
Message-ID: <CAPyD+=CSPxUj_hg7rhTKAw6x36n3OWfe-MpXPj9y_+uQ0ZVdTg@mail.gmail.com>
In-Reply-To: ac257f7c-b297-2127-d19c-32606be13620@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1499

--===============1337923528842892513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Tue, Jul 16, 2019 at 8:51 AM Matthieu Baerts
<matthieu.baerts(a)tessares.net> wrote:
> On 15/07/2019 22:18, Othman, Ossama wrote:
> > My point was that it also introduces a way for compromised privileged
> > processes to potentially (and possibly inadvertently) disable MPTCP at
> > run-time without involving system administrators.  Admittedly, there
> > doesn't appear to be much reason for such compromised processes to do
> > that.   At the very least, I think it might be useful to verify that
> > the process in question has the CAP_NET_ADMIN capability when
> > modifying this variable.
>
> With the current version, I think that this compromised privileged
> process would need the root/full permissions to modify this new sysctl.
> It would need more than one capability I think, no?
> If it is "root", it can then also block MPTCP with NF/IPTables rules,
> remove files, burn the device, become the president of the US, etc.
> Maybe a process with CAP_NET_ADMIN can already block MPTCP sockets.
>
> Maybe I am wrong but I thought that using capabilities was a way to give
> extra permissions to a process to do a bit more (e.g. to create a RAW
> socket) without requiring the full/root rights. To change most sysctl
> (except the ones that check for some specific capabilities), you need
> the full rights, no?

I think it's more accurate to say that the effective user ID needs to
be root in those cases, regardless of which capabilities are granted
or removed.  Since capabilities are not checked in the kernel for
those sysctl variables, a root process without full capabilities could
conceivably alter them, at least as I understand it.  Please correct
me if I am wrong.

Yes, capabilities can be used to grant specific privileges to a
non-root process.  However, capabilities can also be used to restrict
what a root process can do.  This is evident in "pscap" command
output:

$ pscap
ppid  pid   name        command           capabilities
1     220   root        systemd-journal   chown, dac_override,
dac_read_search, fowner, setgid, setuid, sys_ptrace, sys_admin,
audit_control, mac_override, syslog, audit_read
1     261   root        systemd-udevd     full
1     513   root        haveged           sys_admin
1     521   mptcp       mptcpd            net_admin
1     532   root        accounts-daemon   full
...

Only some of the root processes listed above have "full" capabilties.

> And if you have the full rights, you have the
> CAP_NET_ADMIN capability, no?

Yes.  You can't do anything about processes with full capabilities but
you can restrict sysctl variable write access to root processes that
do not have the desired capabilities.

> Is it possible to have "root" processes without CAP_NET_ADMIN
> capability? Or maybe somehow with SELinux?

Sure.  See above.  :)

HTH,
-Ossama

--===============1337923528842892513==--
