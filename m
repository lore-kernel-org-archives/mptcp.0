Content-Type: multipart/mixed; boundary="===============3951462503853777292=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Exposing MPTCP fields in BPF
Date: Mon, 03 Aug 2020 13:17:01 +0200
Message-ID: <CACXrtpQkjCdz2Vh0z3fqHGGwMfFHMYAaMnHHcBTtVX4E5+Bkzg@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5436

--===============3951462503853777292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

In the current effort to handle the MPTCP subflows in BPF programs, I
had to expose the msk's token via the subflow sockets in order to
identify their parent MPTCP connection. This is achieved by adding a
new 'struct bpf_mptcp_sock' as well as a new 'bpf_mptcp_sock' helper
able to provide access to the new structure. This process opened some
questions :

- Extending the exposure of other fields is now quite easy. We may,
for example, expose the 'mptcp_pm_data' structure and maybe modify it
from BPF programs.
Are there use-cases of handling the path manager from BPF ?

- More generally, what are the MPTCP fields that may be interesting to
expose to / modify with BPF ?

Thanks in advance for your answers / ideas !

Nicolas
--===============3951462503853777292==--
