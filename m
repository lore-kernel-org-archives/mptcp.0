Content-Type: multipart/mixed; boundary="===============3062245067186729919=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Thu, 18 Jul 2019 11:57:57 +0200
Message-ID: <fbd2e767-db0c-7301-2921-4c1fa6f916a0@tessares.net>
In-Reply-To: CAPyD+=CSPxUj_hg7rhTKAw6x36n3OWfe-MpXPj9y_+uQ0ZVdTg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1530

--===============3062245067186729919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ossama,

On 16/07/2019 19:45, Othman, Ossama wrote:
> Hi Matthieu,
> =

> On Tue, Jul 16, 2019 at 8:51 AM Matthieu Baerts
> <matthieu.baerts(a)tessares.net> wrote:
>> On 15/07/2019 22:18, Othman, Ossama wrote:
>>> My point was that it also introduces a way for compromised privileged
>>> processes to potentially (and possibly inadvertently) disable MPTCP at
>>> run-time without involving system administrators.  Admittedly, there
>>> doesn't appear to be much reason for such compromised processes to do
>>> that.   At the very least, I think it might be useful to verify that
>>> the process in question has the CAP_NET_ADMIN capability when
>>> modifying this variable.
>>
>> With the current version, I think that this compromised privileged
>> process would need the root/full permissions to modify this new sysctl.
>> It would need more than one capability I think, no?
>> If it is "root", it can then also block MPTCP with NF/IPTables rules,
>> remove files, burn the device, become the president of the US, etc.
>> Maybe a process with CAP_NET_ADMIN can already block MPTCP sockets.
>>
>> Maybe I am wrong but I thought that using capabilities was a way to give
>> extra permissions to a process to do a bit more (e.g. to create a RAW
>> socket) without requiring the full/root rights. To change most sysctl
>> (except the ones that check for some specific capabilities), you need
>> the full rights, no?
> =

> I think it's more accurate to say that the effective user ID needs to
> be root in those cases, regardless of which capabilities are granted
> or removed.  Since capabilities are not checked in the kernel for
> those sysctl variables, a root process without full capabilities could
> conceivably alter them, at least as I understand it.  Please correct
> me if I am wrong.

Thank you for this note!
From what I see in the code, the check for the permissions is done in 2
steps from sysctl_perm()[1]:
- first it gets the mode, that's done in net_ctl_permissions()[2]
because we are in the net root table. So:
  - either the caller has CAP_NET_ADMIN capability and it will get the
same access as root: if the root user can read and write, the user will
be able to do the same.
  - or we take the mode specified in the table, e.g. 644 here, where
only root (id=3D0) can write.
- then it tests which mode is valid for the current user, see test_perm()[3]

[1]
https://elixir.bootlin.com/linux/latest/source/fs/proc/proc_sysctl.c#L446
[2] https://elixir.bootlin.com/linux/latest/source/net/sysctl_net.c#L42
[3]
https://elixir.bootlin.com/linux/latest/source/fs/proc/proc_sysctl.c#L435

So from what I see, you can modify the value of this new sysctl if you
have CAP_NET_ADMIN capability or you are the root user.

So it seems OK, no? Or do you want that only root with net admin
capability can do that? Not one or the other like most of the "net" sysctl?
Or did I miss something? :)

> Yes, capabilities can be used to grant specific privileges to a
> non-root process.  However, capabilities can also be used to restrict
> what a root process can do.  This is evident in "pscap" command
> output:
> =

> $ pscap
> ppid  pid   name        command           capabilities
> 1     220   root        systemd-journal   chown, dac_override,
> dac_read_search, fowner, setgid, setuid, sys_ptrace, sys_admin,
> audit_control, mac_override, syslog, audit_read
> 1     261   root        systemd-udevd     full
> 1     513   root        haveged           sys_admin
> 1     521   mptcp       mptcpd            net_admin
> 1     532   root        accounts-daemon   full
> ...
> =

> Only some of the root processes listed above have "full" capabilties.

That's interesting!
From what I see, systemd-journal might still be able to modify the "net"
sysctls then, no?
Maybe that's not seen as a security issue?

>> And if you have the full rights, you have the
>> CAP_NET_ADMIN capability, no?
> =

> Yes.  You can't do anything about processes with full capabilities but
> you can restrict sysctl variable write access to root processes that
> do not have the desired capabilities.

OK I see.
So now the question is to know if we can trust processes with
CAP_NET_ADMIN capability, right? :)

>> Is it possible to have "root" processes without CAP_NET_ADMIN
>> capability? Or maybe somehow with SELinux?
> =

> Sure.  See above.  :)

Thank you for the review!

Cheers,
Matt

> =

> HTH,
> -Ossama
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3062245067186729919==--
