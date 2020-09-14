Content-Type: multipart/mixed; boundary="===============3586733027913936795=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 13/13] mptcp: simult flow self-tests
Date: Mon, 14 Sep 2020 11:09:53 -0700
Message-ID: <alpine.OSX.2.23.453.2009141109260.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: c1fc87079b24def5cb0a6729481d4b14444296b4.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5860

--===============3586733027913936795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Add a bunch of test-cases for multiple subflow xmit:
> create multiple subflows simulating different links
> condition via netem and verify that the msk is able
> to use completely the aggregated bandwidth.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> tools/testing/selftests/net/mptcp/Makefile    |   3 +-
> .../selftests/net/mptcp/simult_flows.sh       | 293 ++++++++++++++++++
> 2 files changed, 295 insertions(+), 1 deletion(-)
> create mode 100755 tools/testing/selftests/net/mptcp/simult_flows.sh
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3586733027913936795==--
