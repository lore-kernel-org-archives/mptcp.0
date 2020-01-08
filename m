Content-Type: multipart/mixed; boundary="===============1259754476994616905=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Rebase request
Date: Wed, 08 Jan 2020 09:22:45 +0100
Message-ID: <ce14a20b5fe57043948993ed09d5e1451bbf9a4a.camel@redhat.com>
In-Reply-To: a54a945303550dd8ed624bb8801cdb3a780198d2.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3284

--===============1259754476994616905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-07 at 17:31 -0800, Peter Krystad wrote:
> I would like to switch the order of the two commits: "Add path manager
> interface" and "Add ADD_ADDR handling". The addition of ADD_ADDR option
> handling and adding the path manager interface is muddled between these t=
wo
> commits, this switch will clean this up and make further patches for
> optimizing mptcp_options_received structure cleaner.
> =

> I've done the work here:
> =

> https://github.com/pkrystad/mptcp_net-next/tree/switched-0107

I agree the code is cleaner/clearer this way, LGTM!

Thanks,

Paolo

--===============1259754476994616905==--
