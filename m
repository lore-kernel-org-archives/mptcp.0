Content-Type: multipart/mixed; boundary="===============9041047094504018406=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC mptcp 2/2] mptcp: allow dumping subflow
 context to userspace
Date: Thu, 16 May 2019 16:58:52 -0700
Message-ID: <alpine.OSX.2.21.1905161652200.41252@mjmartin-mac01.local>
In-Reply-To: 071168da3f5216a3a7729e69a34e29a43d9e89cb.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1194

--===============9041047094504018406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 14 May 2019, Paolo Abeni wrote:

> Hi,
>
> On Tue, 2019-05-14 at 11:14 +0200, Davide Caratti wrote:
>>      - this is a POC patch where I only dump few members of the subflow,=
 and
>>        put them in a nested attribute so that it's possible to read them=
 in
>>        a program regardless the value of 'subflow_ulp_ops.name'. Please =
let
>>        me know if we should dump additional information, or if some of t=
hose
>>        I included don't make sense.
>
> I personally think that SSN and mapping related info would be useful
> and worthy to add.
>

As we implement multiple subflows and deal with MPTCP-level out-of-order =

reassembly, the mapping-related info will likely move in to the =

MPTCP-level socket. If we expose information about mappings, I think we =

would register a different inet_diag_handler for the MPTCP socket and =

report it there.

--
Mat Martineau
Intel

--===============9041047094504018406==--
