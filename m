Content-Type: multipart/mixed; boundary="===============0154779480029554988=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] LPC proposal draft
Date: Mon, 09 Jul 2018 15:12:59 +0000
Message-ID: <CAKuKrBmc+QmAnh7oEcAz8+szKgwnSidtWvjFhYm5GEu4YZ7T=g@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1807061510550.33244@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 677

--===============0154779480029554988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On Fri, Jul 6, 2018 at 10:22 PM Mat Martineau
<mathew.j.martineau(a)linux.intel.com> wrote:
>
>
> Hello -
>
> Those of us in the weekly web conference yesterday discussed options for
> a Linux Plumber's Conference networking track talk
> (http://vger.kernel.org/lpc-networking.html). The deadline is coming up
> very soon, on Wednesday, 11 July.
>
> Here's a draft proposal, please comment!
>
> """
>
> Implementing Multipath TCP requires both adding a layer above TCP and
> modifying the core in a number of places. The layer additions are
> relatively straightforward: adding a new IPPROTO_MPTCP protocol type,
> overriding existing callbacks from the IP layer, and adding to TCP option
> handling. But even after extensive efforts to minimize changes to the TCP
> core there are a handful of modifications required in order to support
> MPTCP. Unlike protocols that layer cleanly entirely above TCP, MPTCP must
> integrate with low-level TCP operations involving receive windows, sending
> and receiving ACKs, and the RST and FIN signals. We will show where the
> TCP core will be affected, why the changes cannot be avoided, and what we
> have done to avoid impacting TCP performance.
>
> """

Thank you for this draft proposal! That's a very good work for me!

Should we introduce what is MPTCP and who is behind? Maybe something
very short like this?

"""

A community project is underway to add Multipath TCP (RFC-6824) to the
upstream Linux kernel. An existing implementation already adds MPTCP
support in the Linux kernel but this version, even if it is used in
production by different (specialised) companies all over the world,
cannot be upstreamed as it is due to its intrusiveness that needs to
be reduced.

"""

Even if it is obvious for us, should we clearly mention at the end
that we are looking for discussions after that? Maybe something like
this to reuse David's words?

"""

We will show an architecture design proposal where the TCP core will
be affected, why the changes cannot be avoided, and what we have done
to avoid impacting TCP performance. We are looking forward to have
face-to-face discussions and debate.

"""

What do you think about that? Note that it is fine for me to send it
as it is, my additions are mainly linked to details!

Christoph also told me this morning that this version is good for him
and if we want, we can send it as it is without waiting for the last
day!

Have a good day!
Matthieu

>
> --
> Mat Martineau
> Intel OTC



-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============0154779480029554988==--
