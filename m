Content-Type: multipart/mixed; boundary="===============1638895305247251044=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 17th of September 2020
Date: Fri, 18 Sep 2020 18:08:34 +0200
Message-ID: <1a4a3dfe2daa55a37d339b2bd7a1d7bf1c9675fc.camel@redhat.com>
In-Reply-To: 02e1f38d-24eb-ac2f-1516-b8eb52d15003@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5937

--===============1638895305247251044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-09-18 at 17:45 +0200, Matthieu Baerts wrote:
> What to send to netdev?:
>      - ADD/REMOVE addresses changes?:
>          - we need to wait for the next sync between net and net-next
>          - we should send a merge request to David Miller before the WE
>          - TODO: Matth: send this merge request =E2=86=92 Done

After the -net -> net-next merge I think it would be nice submitting
upstream:

selftests: mptcp: add ADD_ADDR mibs check function
mptcp: add ADD_ADDR related mibs
mptcp: send out ADD_ADDR with echo flag
mptcp: add the incoming RM_ADDR support
mptcp: add the outgoing RM_ADDR support
mptcp: rename addr_signal and the related functions

@Geliang: do you agree? could you take care of that? need some help
with the cover letter? (not that I'm the right person for that ;)))

Cheers,

Paolo


--===============1638895305247251044==--
