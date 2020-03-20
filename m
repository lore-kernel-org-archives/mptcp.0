Content-Type: multipart/mixed; boundary="===============6583451550403300145=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/5] squash and cleanup
Date: Fri, 20 Mar 2020 12:08:12 -0700
Message-ID: <alpine.OSX.2.22.394.2003201207560.19124@mcgray1-mobl.amr.corp.intel.com>
In-Reply-To: cover.1584728931.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4032

--===============6583451550403300145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Mar 2020, Paolo Abeni wrote:

> This series contains a "squashable" version of:
>
> subflow: place further subflows on new 'join_list'
>
> and a bunch of minor cleanup (unneeded check after not so recent net-next
> changes)
>
> Rebased tree available at:
>
> https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_14
>
> this supersede the squashed branch posted previously.
>
> Self-tests loop running. Will update here with results.
>
> options.c  |   11 +++--------
> protocol.c |   31 ++++++++++++++++++++++++++++++-
> protocol.h |    2 ++
> subflow.c  |    5 ++++-
> 4 files changed, 39 insertions(+), 10 deletions(-)

Changes look good to me - thanks Paolo!

--
Mat Martineau
Intel
--===============6583451550403300145==--
